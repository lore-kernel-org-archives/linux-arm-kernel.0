From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 Feb 2012 10:23:50 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <4F4DFC3E.2080208@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-2-git-send-email-bill4carson@gmail.com>
 <20120228173027.GB22082@arm.com>
 <4F4D8EBA.90406@gmail.com> <20120229093905.GA17745@arm.com>
 <4F4DFC3E.2080208@gmail.com>
Message-ID: <CAHkRjk6s1HDQi317TMEVgGv-XpRmvqpdMv0LebGnL-F3TaMtig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 February 2012 10:21, bill4carson <bill4carson@gmail.com> wrote:
> On 2012?02?29? 17:39, Catalin Marinas wrote:
>> BTW, there are several coding style issues, I won't go through them but
>> it would help if you have a look at Documentation/CodingStyle
>> (especially comment style, if/else brackets).
>
> Yes, I forgot to run checkpatch.pl to sanitize this patch set.

Don't just rely on checkpatch.pl, have a look at the CodingStyle doc :)

-- 
Catalin
