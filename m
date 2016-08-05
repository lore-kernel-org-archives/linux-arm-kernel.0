From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 05 Aug 2016 11:52:06 +0200
Subject: [PATCH 7/8] ASoC: samsung: s3c24xx_uda134x: debug/error trace
 cleanup
In-Reply-To: <20160804210554.GL10383@sirena.org.uk>
References: <1470317928-25365-1-git-send-email-s.nawrocki@samsung.com>
 <1470317928-25365-8-git-send-email-s.nawrocki@samsung.com>
 <20160804210554.GL10383@sirena.org.uk>
Message-ID: <dc98210f-b87f-443c-f54f-1123f31c7ad3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2016 11:05 PM, Mark Brown wrote:
> On Thu, Aug 04, 2016 at 03:38:47PM +0200, Sylwester Nawrocki wrote:
>> Switch from pr_* to dev_* macros and drop some debug traces.
> 
> This doesn't apply against current code and the previous patch had
> unknown SHA1s suggesting that you've got some other patches in your
> tree, please check and resend.

I suspect the cause is this patch missing:
"ASoC: samsung: Fix clock handling in S3C24XX_UDA134X card"
which I really should have sent as a first one together with
this series. My apologies for the mess. 


I've resent $subject patch and will hold on for a moment with 
PATCH 8/8 as there are large conflicts when I first rebase it 
onto topic/samsung and then try to merge fix/samsung and 
topic/samsung to the for-next branch.
