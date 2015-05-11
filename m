From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 11 May 2015 15:23:24 +0100
Subject: [STLinux Kernel] [PATCH] ARM: STi: DT: STih407: Re-order
 #include <*.dtsi> files
In-Reply-To: <1431353569-13291-1-git-send-email-lee.jones@linaro.org>
References: <1431353569-13291-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150511142324.GA25771@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 11 May 2015, Lee Jones wrote:

> This patch fixes a regression where serial is enabled by the first
> (board) DTSI, then disabled by the second (SoC) file.  To enable
> serial and keep it enabled, we need to include the file which enables
> it last.
> 
> Reported-by: LAVA [via Peter Griffin <peter.griffin@linaro.org>]
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
