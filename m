From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jun 2015 18:58:48 +0100
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1434995379.5657.49.camel@dolka.fr>
References: <5583DD23.90505@arm.com> <1434716194.17448.28.camel@x60s>
 <20150619131315.GR7557@n2100.arm.linux.org.uk>
 <d6d361113992920900137899ae4d1f7b@dolka.fr>
 <20150619152552.GF2936@io.lakedaemon.net>
 <20150619154850.GT7557@n2100.arm.linux.org.uk>
 <20150619171346.GG2936@io.lakedaemon.net>
 <1434908275.5657.17.camel@dolka.fr>
 <20150622120829.GL2936@io.lakedaemon.net>
 <1434995379.5657.49.camel@dolka.fr>
Message-ID: <20150622175847.GX7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 07:49:39PM +0200, Benjamin Cama wrote:
> OK, I understand. I'll try to find the time to test the non-DT case and
> offer a patch. About Russell's one: how is the Signed-off-by going in
> this case? I put his and then mine?

If you produce an entirely separate patch to address Orion5x in the same
way that I've done with Dove, then there's no reason to have my sign-off
on it, because none of it will contain work that I've done.

Also note that I've actually re-sent that patch today, and Andrew says
he'll apply it around -rc1 time, so you don't have to include the Dove
bits in your patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
