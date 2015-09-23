From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Sep 2015 11:07:16 -0700
Subject: Plan for the PBIAS regulator fix?
Message-ID: <20150923180716.GK23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Got any estimate on when you might be sending out the pull request
for the pending regulator fixes for the -rc cycle? Or are you OK
for me to consider commit b9c93646fd5c immutable and use it as
a base for a fixes branch for the related dts change?

Commit b9c93646fd5c ("regulator: pbias: program pbias register
offset in pbias driver") is on -rc1 and would not merge other
regulator fixes upstream even if it got merged with dts changes
before your other regulator fixes.

Regards,

Tony
