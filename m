From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 5 Aug 2015 19:00:02 +0200
Subject: [PATCH v2] ARM: dts: Convert Linkstation Mini to Device Tree
In-Reply-To: <55C23FA8.9030504@free-electrons.com>
References: <1436885641.7145.9.camel@dolka.fr> <20150718185238.GH17961@lunn.ch>
 <55B396A1.1090509@free-electrons.com>
 <1438027893.15635.41.camel@dolka.fr>
 <55C23FA8.9030504@free-electrons.com>
Message-ID: <20150805170002.GF32760@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> I am not sure we need the formal acked-by from Alexey because the dts is
> >> not based on a dts written by him.
> > 
> > It's just that I took all the devices definition from his .c; to me, it
> > counts as derived work, but IANAL.
> 
> For me it is still the decription of the hardware not an derivated work.
> Andrew what is your opinion on it?

Also, IANAL, but GPL "TERMS AND CONDITIONS" part 0 says:

      The "Program", below, refers to any such program or work, and a
      "work based on the Program" means either the Program or any
      derivative work under copyright law: that is to say, a work
      containing the Program or a portion of it, either verbatim or
      with modifications and/or translated into another language.

DT is a language, so i think we are on shaky ground if we did not
consider the possibility it is a derived work.

	 Andrew
