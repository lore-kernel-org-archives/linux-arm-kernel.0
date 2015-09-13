From: peter@korsgaard.com (Peter Korsgaard)
Date: Sun, 13 Sep 2015 17:13:52 +0200
Subject: [PATCH 2/4] ARM: sun8i: Add the A33 AHB1 gates clock driver
In-Reply-To: <87wpvu2vzr.fsf@dell.be.48ers.dk> (Peter Korsgaard's message of
 "Sun, 13 Sep 2015 17:13:12 +0200")
References: <1441977997-29041-1-git-send-email-maxime.ripard@free-electrons.com>
 <1441977997-29041-3-git-send-email-maxime.ripard@free-electrons.com>
 <87wpvu2vzr.fsf@dell.be.48ers.dk>
Message-ID: <87pp1m2vyn.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Peter" == Peter Korsgaard <peter@korsgaard.com> writes:

>>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:
 >> The A33 has different a different gates array than the A23, add the node to
 >> the DT.

 > NIT: 2x different.

 > Shouldn't the a23 one then move from sun8i-a23-a33.dtsi to
 > sun8i-a23.dtsi?

Ahh, I didn't notice patch 3.

-- 
Bye, Peter Korsgaard
