From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 12 Sep 2016 12:24:37 -0700
Subject: [PATCH v2] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <57D60E56.10807@samsung.com>
References: <CGME20160909214851epcas1p3718ae2ac8b9758b2d81e581ab88bf2ce@epcas1p3.samsung.com>
 <20160909214847.20103-1-stephen.boyd@linaro.org> <57D60E56.10807@samsung.com>
Message-ID: <147370827733.17983.2419748714043821743@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chanwoo Choi (2016-09-11 19:09:26)
> Hi Stephen,
> 
> Looks good to me.
> But, there are something that need to be modified.
> - add the author information
> - add the description of driver
> - use the extcon_set_state() instead of extcon_set_cable_state_()
> 
> I modified this patch and applied it because I should send
> the pull request within this week after releasing the rc6.
> 
> I added the comment about the modification.
> 

Ok, sounds good. Thanks.
