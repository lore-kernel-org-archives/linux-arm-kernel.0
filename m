From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 22 Sep 2017 14:27:06 +0530
Subject: [PATCH 0/4] iirqchip: Handle return value of kasprintf
In-Reply-To: <86vakbnofy.fsf@arm.com>
References: <1505894901-9403-1-git-send-email-arvind.yadav.cs@gmail.com>
 <86vakbnofy.fsf@arm.com>
Message-ID: <cd0d74fa-3842-949a-55d9-d5591c6bd615@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Friday 22 September 2017 01:40 PM, Marc Zyngier wrote:
> On Wed, Sep 20 2017 at  1:38:18 pm BST, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> kasprintf() can fail here and we must check its return value.
> Or not. The use of these strings is purely cosmetic (they are only used
> to display various debug information), and printk is perfectly able to
> handle a NULL string.
>
> Refusing to probe an essential piece of HW because a debug feature
> failed seems at best counter-productive.
Yes, Your are right. Sorry for noise. :)
> Thanks,
>
> 	M.
~arvind
