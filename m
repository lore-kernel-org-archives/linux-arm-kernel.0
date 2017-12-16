From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 16 Dec 2017 11:52:07 +0100
Subject: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
In-Reply-To: <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
References: <20171215042528.28715-1-d-gerlach@ti.com>
 <20171215042528.28715-4-d-gerlach@ti.com>
 <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
Message-ID: <CAJZ5v0iRg0Sncqt4s3M5+E0h=HJiEDQ4vnB3=6mFhECCv_Lnng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 3:29 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 15, 2017 at 5:25 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> Document the devicetree bindings that describe Texas Instruments
>> opp-supply which allow a platform to describe multiple regulators and
>> additional information, such as registers containing data needed to
>> program aforementioned regulators.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>
> I need an ACK from Rob on this one.

Actually, how this (and the next patch) is related to the [1-2/4]?
