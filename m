From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 27 Oct 2015 19:04:05 +0100
Subject: [PATCH v4 0/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
References: <1445964626-6484-1-git-send-email-jenskuske@gmail.com>
Message-ID: <20151027190405.ce1dd36f952269e0c23e4b52@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Oct 2015 17:50:20 +0100
Jens Kuske <jenskuske@gmail.com> wrote:

> Changes since v3:
> - add a clock driver specific to the bus gates instead of listing parents in
>   the DTSI
> - skip the holes in the reset controller with of_xlate()

Hi, Maxime, there we are :(. The H3 description is hardcoded and the
next SoCs will ask for more and more code. I wonder what is the use of
a DT...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
