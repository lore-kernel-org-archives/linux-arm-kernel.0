From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 14:24:01 -0800
Subject: [PATCH] ARM: ep93xx: remove deprecated IRQF_DISABLED
In-Reply-To: <1384816931-3680-1-git-send-email-rmallon@gmail.com>
References: <1384816931-3680-1-git-send-email-rmallon@gmail.com>
Message-ID: <20131125222401.GA18365@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 10:22:11AM +1100, Ryan Mallon wrote:
> From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> 
> This patch proposes to remove the use of the IRQF_DISABLED flag
> 
> It's a NOOP since 2.6.35 and it will be removed one day.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---

Applied to next/soc. Thanks!


-Olof
