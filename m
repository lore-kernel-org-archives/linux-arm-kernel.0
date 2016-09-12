From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 12 Sep 2016 18:26:23 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57D6D2A9.3010006@laposte.net>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <57D6D2A9.3010006@laposte.net>
Message-ID: <57D6D72F.3080605@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2016 06:07 PM, Sebastian Frias wrote:
> Hi Mark,
> 
> On 09/12/2016 04:01 PM, Mark Rutland wrote:
>>> 3rd parties could choose to write a driver (as opposed to use say, a user-mode
>>> library) if it fits their programming model better, if they think they would
>>> have better performance, or other reasons.
>>
>> A vendor can always choose to "add value" in this manner. The general
>> expectation of *some* driver being upstreamed remains.
> 
> Yes, that's the idea.

Just to clarify, what I meant is that, using the DT as the authoritative
source of HW description is a way to "add value" to everybody, because both,
3rd-parties and the open-source community get the same information.
This creates the conditions for drivers to exist, with the expectation that
eventually said drivers would be upstreamed.
