From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 17 Feb 2015 21:45:14 +0530
Subject: [PATCH] ARM: extend SMP_ON_UP detection for A5 MPCore devices
 with 1 CPU
In-Reply-To: <1422662026-12968-1-git-send-email-stefan@agner.ch>
References: <1422662026-12968-1-git-send-email-stefan@agner.ch>
Message-ID: <20150217161514.GA2236@afzal-ThinkPad-R50e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sat, Jan 31, 2015 at 12:53:46AM +0100, Stefan Agner wrote:

> On the Vybrid platform this did not lead to CPU faults (so far),
> but is_smp checks evaluate to true which is not optimal
> performance wise.

Just curious, was the performance difference considerable ?

Regards
Afzal
