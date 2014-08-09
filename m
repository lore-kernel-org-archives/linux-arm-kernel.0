From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 9 Aug 2014 13:31:16 -0300
Subject: [PATCH 1/6] ARM: mvebu: Add required ethernet muxing for the
 Armada 370 SoC
In-Reply-To: <20140809171902.7b5d45cc@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140809171902.7b5d45cc@free-electrons.com>
Message-ID: <20140809163116.GA1332@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09 Aug 05:19 PM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Fri,  8 Aug 2014 12:18:51 -0300, Ezequiel Garcia wrote:
> 
> > +				ge0_pins: ge0_pins {
> 
> Would it make sense to name that ge0_rgmii_pins ? And ditto for ge1 ?
> 

Yup, I think it does.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
