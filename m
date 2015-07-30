From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Jul 2015 08:18:50 -0500
Subject: [PATCH V3 02/16] PM / OPP: Create a directory for opp bindings
In-Reply-To: <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
 <4dfe565ff17766b7df127d475d84958e96fdab1b.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <CAL_Jsq+J41c7qx11L13-g0UyD+hY9W36Wu9P+6O3cnDv7ysY6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 5:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> More platform specific extended opp bindings will follow and it would be
> easy to manage them with a directory for opp. Lets create that and move
> the existing opp bindings into it.
>
> Cc: Rob Herring <rob.herring@linaro.org>

Use get_maintainers.pl please so you send to right people and right email.

> Cc: devicetree at vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/{ => opp}/opp.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/power/{ => opp}/opp.txt (100%)
>
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp/opp.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/power/opp.txt
> rename to Documentation/devicetree/bindings/power/opp/opp.txt

"power" seems to be a random collection of things. I'd prefer you move
this to .../bindings/opp/opp.txt.

Rob
