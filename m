From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 21 Aug 2012 12:57:40 +0300
Subject: ARM hugetlb support?
In-Reply-To: <20120820082514.GF27631@e103986-lin>
References: <20120820082514.GF27631@e103986-lin>
Message-ID: <CANOLnOMaV_urZvRL5NF++3UpOQSa_RwL1jfOTdGkn7fN+yZ28Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 11:25 AM, Steve Capper <steve.capper@arm.com> wrote:
> n Mon, Aug 20, 2012 at 00:18:12AM +0100, Grazvydas Ignotas wrote:
>> Hello,
> Hello Grazvydas,
>
>> I've found that hugetlb support patches have been posted some months
>> ago [1]. I've been testing them with very good results [2]. Are there
>> still plans to further develop them and eventually merge them?
>>
>
> We are currently working on HugeTLB and Transparent HugePage support for both
> LPAE and non-LPAE memory descriptors. The non-LPAE HugeTLB patches are based
> on Bill's.
>
> I hope to get some patches out to the list soon.

Sounds promising. If you CC me when sending those patches, I can test
them on CortexA8 with my application.
BTW as you probably know know, Catalin seems to have hugetlb branch for LPAE:
http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=shortlog;h=refs/heads/hugetlb


-- 
Gra?vydas
