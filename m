From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 13 Mar 2012 18:00:49 -0400
Subject: Inconsistent kallsyms data on ARM.
Message-ID: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug(?)  has been seen to float from one ARM build to another since
I started tracking the day-to-day changes in Stephen's linux-next builds.

I see it was discussed earlier:

   https://lkml.org/lkml/2011/8/2/233
   https://lkml.org/lkml/2011/10/8/70

but no concrete cause was nailed down.  Can the linux-next build results
help shed some light on this in any way?  Since it seems sporadic, is
there value in embedding a diagnostic of some sort in the infrastructure
so that when the error is detected, that it prints out more detailed info?

I can provide links to failed linux-next builds, but at the moment, all they
really seem to have is the same repeated error message, like this one:

   http://kisskb.ellerman.id.au/kisskb/buildresult/5869367/

and I don't see that helping folks all that much....

Paul.
