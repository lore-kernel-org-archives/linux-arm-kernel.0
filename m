From: s-anna@ti.com (Suman Anna)
Date: Wed, 12 Nov 2014 11:08:51 -0600
Subject: [PATCHv6 1/5] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-2-git-send-email-s-anna@ti.com>
 <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg@mail.gmail.com>
Message-ID: <54639423.3030607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kumar, Mark, Rob,

On 11/12/2014 09:14 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
>> This patch adds the generic common bindings used to represent
>> a hwlock device and use/request locks in a device-tree build.
>>
> ...
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  .../devicetree/bindings/hwlock/hwlock.txt          | 55 ++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt
> 
> Please ask a DT maintainer to ACK this - otherwise I can't send this to Linus.
> 

Can one of you ack this patch and the next patch [1] so that Ohad can
pick up the series for 3.19? This series has been in works for quite
some time now and was reviewed by each of you at some point of time
(thanks!!), the cover letter [2] has the history of the changes.

regards
Suman

[1] https://patchwork.kernel.org/patch/4898001/
[2] http://marc.info/?l=linux-omap&m=141055365213895&w=2
