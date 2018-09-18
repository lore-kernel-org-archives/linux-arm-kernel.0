From: frowand.list@gmail.com (Frank Rowand)
Date: Tue, 18 Sep 2018 13:09:00 -0700
Subject: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
In-Reply-To: <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
 <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
 <CAL_JsqLTcLVGCmjTMi8GojomP=VbFQ5EqKcGnOPo=Wwh5Lc_mw@mail.gmail.com>
Message-ID: <6414499d-2261-ef50-617e-a743173a3041@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/18 11:55, Rob Herring wrote:
> On Fri, Sep 14, 2018 at 2:32 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 09/13/18 13:28, Rob Herring wrote:
>>> Major changes are I2C and SPI bus checks, YAML output format (for
>>> future validation), some new libfdt functions, and more libfdt
>>> validation of dtbs.
>>>
>>> The YAML addition adds an optional dependency on libyaml. pkg-config is
>>> used to test for it and pkg-config became a kconfig dependency in 4.18.
>>
>> For Ubuntu, the libyaml dependency is provided by the packages:
>>
>>    libyaml-0-2
>>    libyaml-dev
> 
> Yes, but as it is not yet required by anything in the kernel I don't
> think that needs to be documented yet. Also, offhand, I don't think we
> generally document in the kernel distro specifics like package names.
> 
> Rob
> 

Agreed.  I was providing information that might save other people a bit
of research.  It is sufficiently visible in the email thread and does
not need to be in the commit message.
