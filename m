From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 28 Dec 2010 17:52:45 +0300
Subject: [PATCH 1/6 v12] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101222233821.GA20893@alchark-u3s>
References: <AANLkTikAWjK7ACyt=LedhyyrhsCk1WCiyWz182CXMe9C@mail.gmail.com>
	<4D0FE546.7050302@bluewatersys.com>
	<AANLkTinyYKrhTcBMMCE4A2oFQHm11cqSZQozytGu+d6o@mail.gmail.com>
	<4D1011CF.9080800@bluewatersys.com>
	<AANLkTi=7O-HwQRcybnLSt+r+A64g=D7rZY7NbdEMFys3@mail.gmail.com>
	<4D110269.9030805@bluewatersys.com>
	<20101222211815.GA31054@alchark-u3s>
	<4D12730B.2030909@bluewatersys.com>
	<20101222222501.GA32693@alchark-u3s>
	<4D1282DA.4020804@bluewatersys.com>
	<20101222233821.GA20893@alchark-u3s>
Message-ID: <AANLkTik1tcL_ABdnq5r=MCxmLJtdP0nhOzA8irP1n0CC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/23 Alexey Charkov <alchark@gmail.com>:
> This adds support for the family of Systems-on-Chip produced initially
> by VIA and now its subsidiary WonderMedia that have recently become
> widespread in lower-end Chinese ARM-based tablets and netbooks.
>
> Support is included for both VT8500 and WM8505, selectable by a
> configuration switch at kernel build time.
>
> Included are basic machine initialization files, register and
> interrupt definitions, support for the on-chip interrupt controller,
> high-precision OS timer, GPIO lines, necessary macros for early debug,
> pulse-width-modulated outputs control, as well as platform device
> configurations for the specific drivers implemented elsewhere.
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Russell, will you take this for .38? Please note that the last
revision of this patch was also submitted to the ARM Linux patch
tracking system:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6597/1

Best regards,
Alexey
