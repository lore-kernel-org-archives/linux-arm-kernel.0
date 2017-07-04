From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Tue, 4 Jul 2017 14:53:04 +0200
Subject: [PATCH v3] phy: allwinner: phy-sun4i-usb: Add log when probing
In-Reply-To: <20170704123703.18916-1-quentin.schulz@free-electrons.com>
References: <20170704123703.18916-1-quentin.schulz@free-electrons.com>
Message-ID: <d0095286-22be-e6b7-c28b-714d81298f5e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/07/2017 14:37, Quentin Schulz wrote:
> When phy-sun4i-usb's probing fails, it does not print the reason in
> kernel log, forcing the developer to edit this driver to add info logs.
> This commit makes the kernel print the reason of phy-sun4i-usb's probing
> failure or a success message.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Tested-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

Thanks!

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
