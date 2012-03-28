From: alexg@meprolight.com (Alex Gershgorin)
Date: Wed, 28 Mar 2012 14:20:27 +0200
Subject: [PATCH v2] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <CAOMZO5DE0wcdbk7xbXuOFKJ=NNtSrWTPaLjRAdDfewOmPR-eVw@mail.gmail.com>
References: <1332935527-21414-1-git-send-email-alexg@meprolight.com>,
 <CAOMZO5DE0wcdbk7xbXuOFKJ=NNtSrWTPaLjRAdDfewOmPR-eVw@mail.gmail.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD22@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for you comments,

On Wed, Mar 28, 2012 at 8:52 AM, Alex Gershgorin <alexg@meprolight.com> wrote:
> This version rebased for v3.4, also removes ranges from regulators
> who do not have consumers and adds consumers for same regulators.

> > In your subject: prefix it with "ARM" as this patch should go via the arm tree.

> > Also, do not put comments about kernel version in the commit log.
> > If you want to talk about kernel version/patch history you can do so
> > below the --- line.

I will take note of this 
...
> +static struct regulator_consumer_supply vcam_consumers[] = {
> +       /* sgtl5000 */
> +       REGULATOR_SUPPLY("VDDA", "1-000a"),

> > This should be "0-000a" instead.

oops... I will correct this 
