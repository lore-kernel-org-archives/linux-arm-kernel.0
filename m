From: qnguyen@apm.com (Quan Nguyen)
Date: Fri, 29 Jan 2016 11:18:15 +0700
Subject: [PATCH v4 2/3] Documentation: gpio: Update description for X-Gene
 standby GPIO controller DTS binding
In-Reply-To: <20160129024606.GA18663@rob-hp-laptop>
References: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
 <1453792935-19916-3-git-send-email-qnguyen@apm.com>
 <20160129024606.GA18663@rob-hp-laptop>
Message-ID: <CAFopSPQAZSVC3Jg-EbbtJG-ryyMrCMoaqHeROQN8WegqdXekGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 9:46 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 26, 2016 at 02:22:14PM +0700, Quan Nguyen wrote:
>> Update description for X-Gene standby GPIO controller DTS binding to
>> support GPIO line configuration as input, output or external IRQ pin.
>>
>> Signed-off-by: Y Vo <yvo@apm.com>
>> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 39 ++++++++++++++++++----
>>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> Did you change something here? I've already acked this. Please add acks
> when posting new versions.
>
Yes, I did, Rob.
I really appreciate your ack in last version. But some changes were
added on this version and some more on new DT properties description
to come in my next version. I'm going to send out new version shortly
based on recent review comments and I'd appreciate with either ack or
nak.

Thanks,
-- Quan Nguyen
