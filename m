From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 17 Dec 2013 11:30:35 +0100
Subject: [PATCH v9 0/2] PWM: pwm-atmel: add PWM controller driver
In-Reply-To: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
References: <1386916910-24832-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20131217103034.GE13823@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:41:48PM +0800, Bo Shen wrote:
> This patch series add Atmel PWM controller driver support.
> 
> Changes in v9:
>   - Address the comments from Thierry Reding

Hi,

I've pushed a slightly modified version of this series. There were a few
minor whitespace/coding style issues, but perhaps more importantly I've
modified the period change check to be done earlier and in a more
generic way.

Can you please check that the version I've pushed to the for-next branch
still works for you?

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/90468328/attachment.sig>
