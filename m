From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 31 Mar 2014 13:09:49 -0400
Subject: [Linaro-acpi] [PATCH v4 1/3] PSCI: Add initial support for
 PSCIv0.2 functions
In-Reply-To: <53399D62.5060704@arm.com>
References: <1396278179-28181-1-git-send-email-ashwin.chaugule@linaro.org>
 <1396278179-28181-2-git-send-email-ashwin.chaugule@linaro.org>
 <53399D62.5060704@arm.com>
Message-ID: <CAJ5Y-eaC81rqOewzVDEZm=wHbLNWBh32RrLq4nFVa5yHJTT6pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 31 March 2014 12:52, Sudeep Holla <sudeep.holla@arm.com> wrote:

>> +       if (ver == PSCI_RET_EOPNOTSUPP) {
>> +               pr_info("PSCI_ID_VERSION Function not supported in firmware.\n");
>
> IMO you should stop here as the implementation conforming to the specification
> must return a minor version number of 2 and major version number of 0. You
> can't proceed, assume ids and use them.
>

hm, you're right, I missed that.

Cheers,
Ashwin
