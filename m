From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 May 2013 10:19:56 +0200
Subject: [PATCH 04/20] ARM: picoxcell: Remove init_irq declaration in
 machine description
In-Reply-To: <20130514162046.GA16346@page>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130514162046.GA16346@page>
Message-ID: <519496AC.1070809@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

Le 14/05/2013 18:20, Jamie Iles a ?crit :
> Hi Maxime,
> 
> Thanks for this, I'll add it to my tree.  I've modified it slightly to 
> kill off the other irq includes, hopefully that's okay with you.

Yes, I was pretty conservative since I was not familiar with most of the
code, but yes, I'm fine with the changes.

Thank you,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
