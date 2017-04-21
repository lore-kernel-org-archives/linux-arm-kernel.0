From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 20 Apr 2017 23:39:11 -0700
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
In-Reply-To: <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
References: <20170421105405.6a690b35@canb.auug.org.au>
 <CAK8P3a3kHO1NZFJXvDwWO625aEmXoo2540FRKe+YYzoYE9NCSg@mail.gmail.com>
Message-ID: <4b58d5ab-c924-97af-728f-b9f524e62a53@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/17 10:53 PM, Arnd Bergmann wrote:
> On Fri, Apr 21, 2017 at 2:54 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Today's linux-next merge of the pm tree got a conflict in:
>>
>>   include/dt-bindings/genpd/k2g.h
>>
>> between commit:
>>
>>   7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains")
>>
>> from the arm-soc tree and commit:
>>
>>   45da8edd1741 ("dt-bindings: Add TI SCI PM Domains")
>>
>> from the pm tree.
>>
>> I fixed it up (I just used the pm tree version) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
> Dave, Santosh,
>
> any idea what happened here? It seems that we picked up the wrong
> version of the tree, do we need to drop this from arm-soc?
>
Nope. Its because this series was in my 'next' branch for a week or
so and now it made it via arm-soc tree next as well.

I just cleaned up my next head so it linux-next next tag should have
only arm-soc copy.

Regards,
Santosh
