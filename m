From: quozl@laptop.org (James Cameron)
Date: Mon, 29 Oct 2018 16:35:29 +1100
Subject: [PATCH 05/11] DT: marvell,mmp2: Add SSP1 and SSP3
In-Reply-To: <20181010170936.316862-6-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-6-lkundrak@v3.sk>
Message-ID: <20181029053529.GG29685@us.netrek.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 07:09:30PM +0200, Lubomir Rintel wrote:
> There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
> base addresses secret.
> 
> The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
> kernel respectively.

Sorry for the delay.  Love your work!  From my notes, SSP2 is
0xd4036000, and SSP4 is 0xd4039000.  Can be probed by hand in
OpenFirmware or CForth once clocks are on.

-- 
James Cameron
http://quozl.netrek.org/
