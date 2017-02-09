From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 9 Feb 2017 13:13:20 +0100
Subject: [PATCH 1/2] staging: bcm2835-audio: Removed spaces before ')'
In-Reply-To: <20170206075651.4829-1-abhijitnaik27@gmail.com>
References: <20170206075651.4829-1-abhijitnaik27@gmail.com>
Message-ID: <20170209121320.GA16588@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 01:26:50PM +0530, Abhijit Naik wrote:
> bcm2835-vchiq.c and vc_vchi_audioserv_defs.h:
> fixing ERROR: space prohibited before that close parenthesis
> 
> Signed-off-by: Abhijit Naik <abhijitnaik27@gmail.com>
> ---
>  drivers/staging/bcm2835-audio/bcm2835-vchiq.c          | 16 ++++++++--------
>  drivers/staging/bcm2835-audio/vc_vchi_audioserv_defs.h |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)

These two patches do not apply to my tree at all, it looks like someone
else already did this :(

sorry,

greg k-h
