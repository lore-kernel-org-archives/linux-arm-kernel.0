From: mike.kravetz@oracle.com (Mike Kravetz)
Date: Thu, 26 Jul 2018 12:16:29 -0700
Subject: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <87tvomgqyv.fsf@concordia.ellerman.id.au>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
 <87tvomgqyv.fsf@concordia.ellerman.id.au>
Message-ID: <99473e0d-12d8-bbea-fe9c-4e3738ab7f5a@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2018 04:46 AM, Michael Ellerman wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
>> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>>> Does anyone have any suggestion about those patches ?
>>
>> I only took a quick look.  From the hugetlb perspective, I like the
>> idea of moving routines to a common file.  If any of the arch owners
>> (or anyone else) agree, I can do a review of the series.
> 
> The conversions look pretty good to me. If you want to give it a review
> then from my point of view it could go in -mm to shake out any bugs.

Nothing of significance found in a review.  As others have suggested,
the (cross)compiler may be better at finding issues than human eyes.

I also suggest it be added to -mm.
-- 
Mike Kravetz
