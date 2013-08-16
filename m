From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Fri, 16 Aug 2013 12:20:25 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <51E546A6.7010606@parallels.com>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon> <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon> <51E4DC0B.8040908@parallels.com>
 <20130716095349.GB16370@moon> <51E51EF1.3010104@parallels.com>
 <20130716103649.GC24642@n2100.arm.linux.org.uk>
 <51E524D1.2090504@parallels.com>
 <20130716110721.GD24642@n2100.arm.linux.org.uk>
 <51E546A6.7010606@parallels.com>
Message-ID: <520DE0C9.5070907@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

I'm sorry for the delayed response.

On 07/16/2013 05:12 PM, Alexander Kartashov wrote:
> The lines in trouble is
>
> #if SHMLBA > 16384
> #error FIX ME
> #endif

Nevertheless, removing these lines fixes both the compilation
and shared memory alignment issue. Thank you.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
