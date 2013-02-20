From: wni@nvidia.com (Wei Ni)
Date: Wed, 20 Feb 2013 18:29:15 +0800
Subject: [RFC PATCH 4/9] hwmon: (lm90) use macros for the indexes of temp8
 and temp11
In-Reply-To: <51240497.8010909@wwwdotorg.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-5-git-send-email-wni@nvidia.com>
 <51240497.8010909@wwwdotorg.org>
Message-ID: <5124A57B.3050403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2013 07:02 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Using macros for the indexes and nrs of temp8 and temp11.
>> This make the code much clearer.
> 
> Sorry to nit-pick, but those aren't macros, but rather they're enums.

Yes, you are right, it's better to write "enums".
I will change it.

Wei.

> 
> The patch looks good though.
> 
