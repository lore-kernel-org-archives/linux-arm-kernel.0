From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 30 Jul 2015 19:19:59 +0530
Subject: [PATCH V3 02/16] PM / OPP: Create a directory for opp bindings
In-Reply-To: <CAL_Jsq+J41c7qx11L13-g0UyD+hY9W36Wu9P+6O3cnDv7ysY6Q@mail.gmail.com>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
 <CAL_Jsq+J41c7qx11L13-g0UyD+hY9W36Wu9P+6O3cnDv7ysY6Q@mail.gmail.com>
Message-ID: <20150730134959.GB17794@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-07-15, 08:18, Rob Herring wrote:
> On Wed, Jul 29, 2015 at 5:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > More platform specific extended opp bindings will follow and it would be
> > easy to manage them with a directory for opp. Lets create that and move
> > the existing opp bindings into it.
> >
> > Cc: Rob Herring <rob.herring@linaro.org>
> 
> Use get_maintainers.pl please so you send to right people and right email.

Already done, you were just cc'd as an extra guy :)

> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/power/{ => opp}/opp.txt | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)
> >
> > diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp/opp.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/power/opp.txt
> > rename to Documentation/devicetree/bindings/power/opp/opp.txt
> 
> "power" seems to be a random collection of things. I'd prefer you move
> this to .../bindings/opp/opp.txt.

Hmm, sure. That would be better I think.

--------------8<-------------------

Message-Id: <29597667e2c8afdbf396c5fcc9269fb27794131c.1438264123.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 27 Jul 2015 10:04:21 +0530
Subject: [PATCH] PM / OPP: Create a directory for opp bindings

More platform specific extended opp bindings will follow and it would be
easy to manage them with a directory for opp. Lets create that and move
the existing opp bindings into it.

Cc: Rob Herring <rob.herring@linaro.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/{power => opp}/opp.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{power => opp}/opp.txt (100%)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
similarity index 100%
rename from Documentation/devicetree/bindings/power/opp.txt
rename to Documentation/devicetree/bindings/opp/opp.txt
