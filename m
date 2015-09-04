From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 04 Sep 2015 17:37:57 +0100
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E9C33A.2080801@free.fr> (Mason's message of "Fri, 04 Sep 2015
 18:13:46 +0200")
References: <55E5CED8.7000408@free.fr> <55E5D945.3040504@gmail.com>
 <55E722F2.50905@free.fr> <yw1xy4goyc3z.fsf@unicorn.mansr.com>
 <55E73971.8030406@free.fr> <55E9C33A.2080801@free.fr>
Message-ID: <yw1x4mjaxhqy.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 02/09/2015 20:01, Mason wrote:
>
>> On 02/09/2015 19:17, M?ns Rullg?rd wrote:
>> 
>>> Use the latest DT from my tree.  It looks like you're missing some
>>> changes.
>> 
>> Indeed, my repo is not up-to-date. (I was vaguely worried that you'd
>> have made further changes that I'd have to revert when back-porting
>> to 3.14)
>> 
>> I'll try upgrading and report back.
>> 
>> By the way, did you write the DT from scratch?
>> 
>> Are there people walking this earth that can write device tree like C?
>
> No cigar :-(
>
> There's just too much DT syntax that flies light-years over my head.
> #address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
> Basically, all I understand is /dts-v1/;
> (Anyone have links to good tutorials?)

Here's something: http://devicetree.org/Device_Tree_Usage

-- 
M?ns Rullg?rd
mans at mansr.com
