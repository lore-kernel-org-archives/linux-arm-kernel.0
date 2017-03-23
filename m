From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Mar 2017 10:31:54 +0000
Subject: [PATCH 0/2] meson-sm: Fix issues when reading data from sm
In-Reply-To: <m24lylnw5q.fsf@baylibre.com>
References: <20170303151759.8330-1-carlo@caione.org>
 <m24lylnw5q.fsf@baylibre.com>
Message-ID: <20170323103153.GA9287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 08:55:29AM -0700, Kevin Hilman wrote:
> Carlo Caione <carlo@caione.org> writes:
> 
> > From: Carlo Caione <carlo@endlessm.com>
> >
> > While working on a related driver I noticed a couple of problems in the
> > meson-sm driver. The problems are unrelated but since the fixes touch the same
> > codebase I decided to submit these in the same patchset.
> 
> Applied to amlogic tree, branch: v4.12/drivers
> 
> I'd prefer to have acks from Mark and Srini, but since this has been on
> the list for awhile, I'm guessing that isn't going to happen, so
> consider this a request.

>From a quick scan, this looks fine to me. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
