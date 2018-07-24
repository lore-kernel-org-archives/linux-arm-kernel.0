From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jul 2018 08:43:46 -0700
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <20180724152514.GJ13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
 <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
 <20180724152514.GJ13268@sirena.org.uk>
Message-ID: <CAD=FV=WHJcAoR7Y_uhi7_GbVzy6K8FnovVFVRz8js0REONox=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 24, 2018 at 8:25 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 24, 2018 at 08:11:30AM -0700, Doug Anderson wrote:
>
>> RPMh itself landed in Andy's tree and he sent a pull request on
>> Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
>> Driver updates for 4.19") AKA
>> <https://patchwork.kernel.org/patch/10539125/>.
>
>> It doesn't look like arm-soc has picked up Andy's pull request yet
>> though.  If having it in arm-soc is a requirement then I'm happy to
>> monitor arm-soc and ping this thread again when it's there.
>
> There was also some other thing called command DB as well which was a
> separate series.  Ideally there'd be a branch I could pull as there's a
> build dependency on rpmh so I can't apply until the code has landed in
> my tree, don't know what command DB is exactly.

Yup.  That one landed in May and is already in mainline Linux.  Refer
to commit 312416d9171a ("drivers: qcom: add command DB driver").

Adding Andy to this thread (I guess he wasn't on it?).  Hopefully he
can provide you with the branch.

-Doug
