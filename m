From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 5 Dec 2017 12:54:12 +0300
Subject: [PATCH 0/7 v2] net: Fix platform_get_irq's error checking
In-Reply-To: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <d4b55643-2f28-d684-0603-83c6f336a23b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/4/2017 8:48 PM, Arvind Yadav wrote:

> The platform_get_irq() function returns negative number if an error
> occurs, Zero if No irq is found and positive number if irq gets successful.

    No, returning 0 is not a failure indication anymore. It used to be but not 
any longer...

> platform_get_irq() error checking for only zero is not correct.

[...]

MBR, Sergei
