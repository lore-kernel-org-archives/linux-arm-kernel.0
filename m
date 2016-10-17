From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Oct 2016 14:10:41 +0100
Subject: ARM64-cpuinfo: Combine six calls for sequence output into one
 seq_printf() call in c_show()
In-Reply-To: <d012ad47-9688-5c9c-6ffd-78300c7b21ae@users.sourceforge.net>
References: <83d98772-8872-1b75-a9a5-5f08b8462e18@users.sourceforge.net>
 <20161017105605.GB29095@leverpostej>
 <a09542e6-9851-45ef-583d-338205217cfc@users.sourceforge.net>
 <20161017123726.GE29095@leverpostej>
 <d012ad47-9688-5c9c-6ffd-78300c7b21ae@users.sourceforge.net>
Message-ID: <20161017131040.GH29095@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 02:50:57PM +0200, SF Markus Elfring wrote:
> > I prefer the code as-is. Unless there's a compelling reason to change it.
> 
> Is the chance for faster log output interesting enough?

Is there a particular user that cares today, or are we trying to work
backwards to a rationale?

Thanks,
Mark.
