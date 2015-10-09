From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Oct 2015 16:13:34 -0700
Subject: [PATCH v3 2/7] MAINTAINERS: Add myself for the new VC4 (RPi GPU)
 graphics driver.
In-Reply-To: <CACvgo53ftyjj=LhsNuePnjH2Bez5SAG5cwk=7gzMhmMPMYOnew@mail.gmail.com>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-3-git-send-email-eric@anholt.net>
 <CACvgo53ftyjj=LhsNuePnjH2Bez5SAG5cwk=7gzMhmMPMYOnew@mail.gmail.com>
Message-ID: <87fv1jljoh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Emil Velikov <emil.l.velikov@gmail.com> writes:

> Hi Eric,
>
> On 9 October 2015 at 22:27, Eric Anholt <eric@anholt.net> wrote:
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: Mark it Supported, not Maintained.
>>
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7ba7ab7..e331e46 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3653,6 +3653,12 @@ S:       Maintained
>>  F:     drivers/gpu/drm/sti
>>  F:     Documentation/devicetree/bindings/gpu/st,stih4xx.txt
>>
>> +DRM DRIVERS FOR VC4
>> +M:     Eric Anholt <eric@anholt.net>
>> +T:     git git://github.com/anholt/linux
> You might want to add dri-devel as mailing list, at least initially.

I believe that's already implied by the general entry for dri-devel:

./scripts/get_maintainer.pl -f drivers/gpu/drm/vc4/vc4_drv.c
Eric Anholt <eric@anholt.net> (supporter:DRM DRIVERS FOR VC4)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
dri-devel at lists.freedesktop.org (open list:DRM DRIVERS)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151009/312d8e77/attachment.sig>
