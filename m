From: mpe@ellerman.id.au (Michael Ellerman)
Date: Thu, 26 Jul 2018 21:46:00 +1000
Subject: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
Message-ID: <87tvomgqyv.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>> Does anyone have any suggestion about those patches ?
>
> I only took a quick look.  From the hugetlb perspective, I like the
> idea of moving routines to a common file.  If any of the arch owners
> (or anyone else) agree, I can do a review of the series.

The conversions look pretty good to me. If you want to give it a review
then from my point of view it could go in -mm to shake out any bugs.

cheers
