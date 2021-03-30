import warnings

warnings.filterwarnings('ignore', message='.*invalid escape sequence.*', module=".*pygments.*")
warnings.filterwarnings('ignore', message='.*on_trait_change is deprecated: use observe instead.*')
warnings.filterwarnings('ignore', message='.*was set from the constructor.*', category=Warning, module='IPython.*')
warnings.filterwarnings('ignore', message='.*use the instance .help string directly, like x.help.*', category=DeprecationWarning, module='IPython.*')

