From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 11 Jun 2013 17:12:19 +0530
Subject: [PATCH 02/11] gpio: davinci: coding style correction
In-Reply-To: <1369206634-6778-3-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-3-git-send-email-avinashphilip@ti.com>
Message-ID: <51B70D1B.1080208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2013 12:40 PM, Philip Avinash wrote:
> 1. Corrects coding and commenting styles
> 2. Variables name change to meaningful name
> 3. Remove unnecessary variable usage
> 4. Add BINTEN macro definition
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

As Russell mentioned, the 80 char limit changes are churn. I looked at
the variable name renaming and that's also churn with little benefit.
The only changes that are probably worth doing are alphabetical ordering
of include files, fixes for mult-line commenting style and usage of
macro for register offset.

As I started reviewing these patches, I also started fixing some of the
comments I had and I have pushed the resulting work here:

https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=devel-gpio

It is only compile tested, but I hope this will serve as good starting
point for your next submission.

Thanks,
Sekhar
