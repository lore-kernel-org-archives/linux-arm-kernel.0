From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Dec 2014 13:15:58 +0000
Subject: [STLinux Kernel] [PATCH v3 4/4] ARM: sti: Provide DT nodes for
 SBC SSC[0..2]
In-Reply-To: <1418043214-14324-5-git-send-email-lee.jones@linaro.org>
References: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
 <1418043214-14324-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20141208131558.GA29220@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 08 Dec 2014, Lee Jones wrote:

> The Synchronous Serial Controller is used to provide SPI.
> 
> These are the ports which are located on the Stand-By Controller (SBC).

After my series which adds stih410 SoC support, these nodes should now live in the
common stih407-family.dtsi file (common to both SoC's).

regards,

Peter.
