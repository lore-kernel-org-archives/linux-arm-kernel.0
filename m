From: bhutchings@solarflare.com (Ben Hutchings)
Date: Tue, 6 Dec 2011 15:24:29 +0000
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: prevent
 dobule restart of interface on FDX/HDX change
In-Reply-To: <0b92136d69e509a6ce49b526e1834f0ec90b04a4.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <0b92136d69e509a6ce49b526e1834f0ec90b04a4.1323163127.git.LW@KARO-electronics.de>
Message-ID: <1323185069.7454.263.camel@deadeye>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You shouldn't repeat the subject of the whole series in the subject of
each patch.  Just put the name of the component you're changing (in this
case, 'fec: prevent dobule restart of interface on FDX/HDX change').

(Nitpick: typo in 'double'.)

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
