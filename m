From: josh.coombs@gmail.com (Josh Coombs)
Date: Wed, 25 May 2016 16:59:31 -0400
Subject: Modern kernel on a Chumby
Message-ID: <CAMW5UfYH6UiaB1ddRT0KBP1thyyebnCw2h4VigYQQ55v4MYqdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've likely bitten off way more than I can chew but I'd like to see if
this is possible:  I have a i.MX21 powered 'original' Chumby happily
running on a modified 2.6.16 kernel, ideally I'd like to do the
legwork to get it running on a current, mainline kernel.  Looking at
4.6 I see a single i.MX21 device supported by a board file, the
mx21ads.  Flipping through the list archives I see discussions of
i.MX21 being moved to device tree operation but I can't see any signs
of any such devices actually being supported that way.

Should I try to bash up support based on the mx21ads or is there a
device tree template I can start from?

Josh C
