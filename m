From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 19 Oct 2015 16:34:13 +0300
Subject: [PATCH V2 17/30] perf: changing pmu::setup_aux() parameter to
 include event
In-Reply-To: <1445192687-24112-18-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
 <1445192687-24112-18-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <87oafvgey2.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> For some tracers the event carries information to be embedded
> in the private structure returned by setup_aux().

You need to mention here what these tracers are and which bits of
event's information they need in their setup_aux(). Right now I can look
it up in this patchset, but when this code gets merged it will make it
easier to understand why this change was made.

Now, I understand that you're interested in event::attr in your
setup_aux(), I have more comments on that in that other patch. :)

Cheers,
--
Alex
