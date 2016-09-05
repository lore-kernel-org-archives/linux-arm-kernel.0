From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 5 Sep 2016 12:15:09 +0200
Subject: [PATCHv2] pwm: lpc-18xx: use pwm_set_chip_data
In-Reply-To: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
References: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160905101509.GE31424@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 06:47:09PM +0200, Olliver Schinagl wrote:
> The lpc18xx driver currently manipulates the pwm_device struct directly
> rather then using the pwm_set_chip_data. While the current method may
> save a clock cycle or two, it is more obvious that data is set to
> the local chip data pointer.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
> Hi,
> 
> This is a resend of a patch-series I sent last year. There was no technical
> related feedback and so I am re-sending the patch as is. I did rebase it to
> Linus's current master.
> 
> Changes since v1:
> 	- removed wrongfully added sun4i patch
> 	- split patch series into a single patch
> 	- added author
> 
>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied with minor bikeshedding.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/e6185af0/attachment.sig>
