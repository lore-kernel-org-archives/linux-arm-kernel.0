From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 12 Oct 2016 13:17:04 +0200
Subject: [PATCH 0/2] ARM: at91: properly handle LPDDR poweroff
In-Reply-To: <1791580.DIVsjjyavb@ws-stein>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
 <1791580.DIVsjjyavb@ws-stein>
Message-ID: <20161012111704.5mhtu4pjv2vncam5@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2016 at 08:00:30 +0200, Alexander Stein wrote :
> Hi Alexandre,
> 
> On Friday 07 October 2016 18:34:25, Alexandre Belloni wrote:
> > Hi,
> > 
> > This patch set improves LPDDR support on SoCs using the Atmel MPDDR
> > controller.
> > 
> > LPDDR memoris can only handle up to 400 uncontrolled power offs in their
> > life. The proper power off sequence has to be applied before shutting down
> > the SoC.
> > 
> > I'm not too happy with the code duplication but this is a design choice
> > that has been made before because both shitdown controler are really
>                                          ^^^^^^^^
> 
> I guess you mean shutdown? :) Same for the suject of 2nd patch.
> 

I'm planning to send a v2, hopefully fixing my typos ;)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
