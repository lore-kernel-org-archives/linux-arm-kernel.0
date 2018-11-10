From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 10 Nov 2018 21:43:17 +0100
Subject: [PATCH] ARM: dts: pxa3xx: add gcu node
In-Reply-To: <20181105191827.3860-1-daniel@zonque.org> (Daniel Mack's message
 of "Mon, 5 Nov 2018 20:18:27 +0100")
References: <20181105191827.3860-1-daniel@zonque.org>
Message-ID: <87muqgll3u.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> Add a device node for hardware graphic acceleration.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Hi Daniel,

> +	gcu: display-controller at 54000000 {
> +		compatible = "marvell,pxa300-gcu";
Isn't every IP devicetree entry supposed to have a documentation in
Documentation/devicetree going along a definition in the .dtsi files ?

Cheers.

-- 
Robert
