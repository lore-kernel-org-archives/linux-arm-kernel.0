From: hs@denx.de (Heiko Schocher)
Date: Mon, 07 Dec 2009 13:27:17 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <309002C0DA137042828828FC53D7A9347E212D14D4@IL-MB01.marvell.com>
References: <4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
	<4B1931B3.90301@denx.de>
	<20091204163850.GC20386@n2100.arm.linux.org.uk>
	<4B194C8B.7070505@denx.de>
	<20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<309002C0DA137042828828FC53D7A9347E212D14D4@IL-MB01.marvell.com>
Message-ID: <4B1CF4A5.2080201@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ronen,

Ronen Shitrit wrote:
> It's definitely this issue. 
> If I disable L2 everything works.

How did you exactly disabled the L2 Cache? And on which system
did you this test?

thanks
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
