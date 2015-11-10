From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 10 Nov 2015 14:54:13 +0000
Subject: [PATCH] Documentation: dt: Add bindings for Secure-only devices
In-Reply-To: <20151110145146.GA1551@rob-hp-laptop>
References: <1446127303-5082-1-git-send-email-peter.maydell@linaro.org>
 <CAL_JsqJz+w2SYEBLVGdZNS6J1tmt5VWV0q1G_Z2rgFfch6J=2A@mail.gmail.com>
 <CAFEAcA8qgFFhrmXePtO_xQx=YEHK8dSA-1SacR5NsQWSNTwj-w@mail.gmail.com>
 <20151110145146.GA1551@rob-hp-laptop>
Message-ID: <CAFEAcA8tLTmb3kOmnddxcMhEP1KZ-iS-N53CVBxHqfVioDKFvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2015 at 14:51, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 30, 2015 at 08:07:34PM +0000, Peter Maydell wrote:
>> +    status = "okay"; secure-status = "okay"; // ditto
>> +    secure-status = "okay";                  // ditto
>> +    // neither explicitly defined: ditto
>>
>> (Do you want the full set of 9 options you get from multiplying
>> out "okay" vs "disabled" vs not-set for each property?)
>
> Better to err on completeness. The inheritance is easily missed.
>
> Also, one nit. Use C style comments so when people copy-n-paste this it
> is the correct style.

OK; I'll send out a v2 with these fixes.

thanks
-- PMM
