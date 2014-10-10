From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Oct 2014 12:25:17 -0700
Subject: [PATCH v3 0/2] bus: brcmstb_gisb: misc fixes
In-Reply-To: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
References: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <5438329D.1040600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 09/22/2014 11:02 AM, Florian Fainelli wrote:
> Hi Arnd,
> 
> This patch set contains two small fixes for the Broadcom GISB bus
> arbiter code. First patch makes sure we do register a fault code for
> ARM platforms, second patch is a fix when the code is used on a PM
> capable system.

Once the merge window re-opens in about a week from now, how do you want
me to submit those patches? Do you want them as part of a brcmstb pull
request, or something else?

Thank you!

> 
> Florian Fainelli (2):
>   bus: brcmstb_gisb: register the fault code hook
>   bus: brcmstb_gisb: save and restore GISB timeout
> 
>  drivers/bus/brcmstb_gisb.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
