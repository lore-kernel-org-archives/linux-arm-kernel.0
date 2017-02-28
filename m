From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 28 Feb 2017 21:48:50 +0100
Subject: [PATCH 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <CAC3K-4rCp3K8FDRQOoL5fG+pwM_H6UpKvQWqrNpysgAss--Xcg@mail.gmail.com>
References: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
 <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
 <CACna6rw1oeUn=QuD-c+X8uokypSEqXUP3yqmiMEK2wgMD-ENeQ@mail.gmail.com>
 <CAC3K-4rCp3K8FDRQOoL5fG+pwM_H6UpKvQWqrNpysgAss--Xcg@mail.gmail.com>
Message-ID: <CACna6rzX=6MpcuQ8iPa_bLCf6f0UGO0hsHyD1X2pn=s6p=SA7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 February 2017 at 21:46, Jon Mason <jon.mason@broadcom.com> wrote:
> On Tue, Feb 28, 2017 at 3:43 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> On 28 February 2017 at 21:31, Jon Mason <jon.mason@broadcom.com> wrote:
>>> @@ -70,10 +70,19 @@
>>>                         clocks = <&periph_clk>;
>>>                 };
>>>
>>> -               local-timer at 20600 {
>>> +               timer at 20600 {
>>
>> Is there a reason for this rename? I don't really have preference for
>> any name, it's just we shouldn't keep renaming this depending of
>> personal preferences.
>>
>> It also doesn't seem like adjusting to any schema:
>> bcm63138.dtsi uses local-timer at 1e600
>> bcm-nsp.dtsi uses twd-timer at 20600
>> berlin2cd.dtsi uses local-timer at ad0600
>> berlin2.dtsi uses local-timer at ad0600
>> berlin2q.dtsi uses local-timer at ad0600
>
> This was a suggestion from Sergei Shtylyov
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395160.html

Good to know, thanks!

-- 
Rafa?
