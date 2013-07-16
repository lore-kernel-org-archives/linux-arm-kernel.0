From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Tue, 16 Jul 2013 14:47:45 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <20130716103649.GC24642@n2100.arm.linux.org.uk>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon> <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon> <51E4DC0B.8040908@parallels.com>
 <20130716095349.GB16370@moon> <51E51EF1.3010104@parallels.com>
 <20130716103649.GC24642@n2100.arm.linux.org.uk>
Message-ID: <51E524D1.2090504@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 02:36 PM, Russell King - ARM Linux wrote:
> shmget() doesn't allocate space in the process for the SHM region.  It
> merely creates the shm memory and returns an identifier for it which can
> later be used by shmat() to map it.
Thank you for the correction, I meant shmat() in that comment indeed.
I'm sorry for the inconvenience.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
