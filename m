From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Sat, 17 Oct 2015 10:11:25 -0700
Subject: [PATCH] pinctrl: ssbi: fix function name typo
In-Reply-To: <6327573.Mj84IgUkQi@wuerfel>
References: <6327573.Mj84IgUkQi@wuerfel>
Message-ID: <20151017171125.GQ24668@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 16 Oct 13:41 PDT 2015, Arnd Bergmann wrote:

> The two newly added qcom ssbi pinctrl drivers have the same bug
> from a function name that apparently got changed in one place
> but not another, resulting in a build error when CONFIG_DEBUG_FS
> is disabled:
> 
> drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c:652:14: error: 'pm8xxx_mpp_dbg_show' undeclared here (not in a function)
> 
> This fixes the two identifiers.

Sorry about this Arnd.

Jonas Gorski found this a few days ago and Linus picked it up today, so
it's in the pipe already.

Regards,
Bjorn
