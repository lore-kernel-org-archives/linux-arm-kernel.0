From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Mar 2015 10:53:07 +0000
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
 <CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
 <CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
 <CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
 <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
 <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
Message-ID: <20150311105307.GW28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 08:20:43AM +0530, Viresh Kumar wrote:

Please don't send upstream e-mail to my work account, I use this address
pretty consistently for upstream.  Upstream mail to my work account
frequently ends up unread.

> On 6 March 2015 at 11:19, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> > On 5 March 2015 at 17:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > About putting
> > those stuff into regulator driver, I think you mean creating a
> > "virtual regulator
> > device" and put all the voltage controlling complex into the driver, right?
> > Maybe it's a good idea in this case, but I am sure if this kind of
> > virtual regulator is acceptable.

> @Mark: Is this allowed to create virtual regulator for a CPU ?

I don't really know what the above means or what problem it's supposed
to solve.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/a3416b49/attachment-0001.sig>
