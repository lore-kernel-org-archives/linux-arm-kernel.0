From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 12 May 2016 14:52:02 +0300
Subject: [PATCH v7 0/5] ACPI: parse the SPCR table
In-Reply-To: <1bff98e3-2d94-ed76-1165-ed7d43bbfcf3@jonmasters.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1bff98e3-2d94-ed76-1165-ed7d43bbfcf3@jonmasters.org>
Message-ID: <bc91f503-cee5-db03-51bf-a36ef3e95a1f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

In v7 I addressed the issues that were brought up by Rafael J . Wysocki
(but I still do not have ACK from ACPI people).

The issue with D02 will be addressed in a separate patch.

There possibly is an issue with 16550 and command line console with I am
investigating and probably will address in a separate patch.

I know no other problems with it and reviewers seem happy.

So I believe this patchset could be pulled.  If needed, I will send v8.

Thank you
Aleksey Makarov

On 05/12/2016 11:20 AM, Jon Masters wrote:
> On 03/31/2016 09:40 AM, Aleksey Makarov wrote:
> 
>> 'ARM Server Base Boot Requirements' [1] mentions SPCR (Serial Port
>> Console Redirection Table) [2] as a mandatory ACPI table that
>> specifies the configuration of serial console.
> 
> Hi Aleksey,
> 
> Can you summarize the status of this patch series?
> 
> Jon.
> 
