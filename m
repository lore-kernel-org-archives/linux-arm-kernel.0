From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 May 2018 11:30:55 +0530
Subject: [PATCH v5 00/14] CPU scaling support for msm8996
In-Reply-To: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180504060055.2pdb6tirhjboy2rq@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-05-18, 14:52, Ilia Lin wrote:
> [v5]
>  * Rebased
>  * Adressed comments from Bjorn
>  * Adressed comments from Viresh
>  * Adressed comments from Sricharan
>  * Adressed comments from Nicolas
>  * Adressed comments from Rob
>  * Adressed comments from Mark

s/Adressed/Addressed/

And that's not how the history should be present here. I don't have
any clue on what I commented on in the previous versions. Now that
there is no clear history available, I need to go look at my previous
replies to understand that. That's not right.

You should mention the exact changes here and you can include the name
of the reviewer in parenthesis. Like this:

* Replaced kmalloc with kzalloc (Viresh).

-- 
viresh
