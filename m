From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 14 Jun 2013 17:45:10 +0900
Subject: [PATCH v2 2/3] ARM: tegra: split setting of CPU reset handler
In-Reply-To: <51BA1BBF.6050106@wwwdotorg.org>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-3-git-send-email-acourbot@nvidia.com>
 <51BA1BBF.6050106@wwwdotorg.org>
Message-ID: <CAAVeFuL0fsFk=rODaE9C8k04CacvyNu3AMrqDgHBOitY93tEpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 4:21 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/13/2013 03:12 AM, Alexandre Courbot wrote:
>> Not all Tegra devices need to set the CPU reset handler in the same way.
>
> s/need/can/ ?

Fixed, thanks!
Alex.
